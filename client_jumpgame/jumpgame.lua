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
  jumpgameWindow:destroy()
  moveButtonLeftEvent = nil
end

function JumpGame.create()
  jumpgameWindow = g_ui.displayUI('jumpgame.otui')
  jumpButton = jumpgameWindow:getChildById('jumpButton')
  JumpGame.moveLeftHandler(true)
end

function JumpGame.destroy()
  jumpgameWindow:destroy()
  JumpGame.moveLeftHandler(false)
end

function JumpGame.moveLeft()
  if jumpButton:getMarginRight() + jumpButton:getWidth()*1.75 < jumpgameWindow:getWidth()  then
    jumpButton:setMarginRight(jumpButton:getMarginRight() + 10)
  else
    JumpGame.reset()
  end
end

function JumpGame.reset()
  jumpButton:setMarginRight(0)
  jumpButton:setMarginTop(math.random(0,jumpgameWindow:getHeight()-jumpButton:getHeight()*3))
end

function JumpGame.moveLeftHandler(bool)
  if bool then
    -- Interrompe o evento anterior (se existir) antes de criar um novo
    if moveButtonLeftEvent ~= nil then
      removeEvent(moveButtonLeftEvent)
      moveButtonLeftEvent = nil
    end
    JumpGame.reset()
    moveButtonLeftEvent = cycleEvent(JumpGame.moveLeft, 100)
  else
    -- Interrompe o evento atual (se existir)
    if moveButtonLeftEvent ~= nil then
      removeEvent(moveButtonLeftEvent)
      moveButtonLeftEvent = nil
    end
    JumpGame.reset()
  end
end
