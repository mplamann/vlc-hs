import Sound.VLC
import Control.Concurrent.Thread.Delay

skywrath = "https://hydra-media.cursecdn.com/dota2.gamepedia.com/e/e0/Drag_inthebag_01.mp3"

main :: IO ()
main =
  with_vlc $ \inst ->
    with_media_at_location inst skywrath $ \m ->
      with_media_player_of_media m $ \mp -> do
        set_volume mp 50
        play mp
        delay (5 * 1000000)
        set_volume mp 100
        set_position mp 0
        delay (5 * 1000000)
        stop mp
