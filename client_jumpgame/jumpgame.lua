moveButtonLeftEvent = nil
jumpgameWindow = nil
JumpGame = {}

function init()
  connect(g_game, { onLogin = JumpGame.create,
  onGameEnd = JumpGame.destroy })
end

function terminate()
  disconnect(g_game, { onLogin = JumpGame.create,
                  onGameEnd = JumpGame.destroy })
  removeEvent(moveButtonLeftEvent)
  JumpGame.destroy()
  moveButtonLeftEvent = nil
end

-- create window and starts the minigame
function JumpGame.create()
  jumpgameWindow = g_ui.displayUI('jumpgame.otui')
  jumpButton = jumpgameWindow:getChildById('jumpButton')
  JumpGame.moveLeftHandler(true)
end
--destroys window and stops moving event
function JumpGame.destroy()
  jumpgameWindow:destroy()
  JumpGame.moveLeftHandler(false)
end

-- makes button move left
function JumpGame.moveLeft()
  -- if the next movement of button is not coliding with window border then it moves
  if jumpButton:getMarginRight() + jumpButton:getWidth()*1.75 < jumpgameWindow:getWidth()  then
    jumpButton:setMarginRight(jumpButton:getMarginRight() + 10)
    -- if colides, then reset
  else
    JumpGame.reset()
  end
end

--reset x position to the corner and sets a random y position to the "Jump!" button
function JumpGame.reset()
  jumpButton:setMarginRight(0)
  jumpButton:setMarginTop(math.random(0,jumpgameWindow:getHeight()-jumpButton:getHeight()*3))
end

-- this function turn on or off (based on bool input value) the cycleEvent that calls the moveleft() function
function JumpGame.moveLeftHandler(bool)
  if bool then
    -- interrupts previous event (if exists) before creating a new one
    if moveButtonLeftEvent ~= nil then
      removeEvent(moveButtonLeftEvent)
      moveButtonLeftEvent = nil
    end
    JumpGame.reset()
    moveButtonLeftEvent = cycleEvent(JumpGame.moveLeft, 100)
  else
    -- interrupts current event (if exists)
    if moveButtonLeftEvent ~= nil then
      removeEvent(moveButtonLeftEvent)
      moveButtonLeftEvent = nil
    end
    JumpGame.reset()
  end
end
