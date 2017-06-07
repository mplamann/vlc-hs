{-# LANGUAGE ForeignFunctionInterface, EmptyDataDecls #-}

module Sound.VLC
   where

import Foreign
import Foreign.Ptr
import Foreign.C.Types
import Foreign.C.String

import qualified Sound.VLC.Internal as I

type Instance = Ptr I.Instance
type Media = Ptr I.Media
type MediaPlayer = Ptr I.MediaPlayer

with_vlc :: (Instance -> IO a) -> IO a
with_vlc f = do
  inst <- I.libvlc_new 0 nullPtr
  result <- f inst
  I.libvlc_release inst
  return result

with_media_at_location :: Instance -> String -> (Media -> IO a) -> IO a
with_media_at_location inst loc f = do
  m <- I.libvlc_media_new_location inst =<< newCAString loc
  result <- f m
  I.libvlc_media_release m
  return result

with_media_player_of_media :: Media -> (MediaPlayer -> IO a) -> IO a
with_media_player_of_media m f = do
  mp <- I.libvlc_media_player_new_from_media m
  result <- f mp
  I.libvlc_media_player_release mp
  return result

play :: MediaPlayer -> IO ()
play = I.libvlc_media_player_play

stop :: MediaPlayer -> IO ()
stop = I.libvlc_media_player_stop

get_volume :: MediaPlayer -> IO Int
get_volume = I.libvlc_audio_get_volume

set_volume :: MediaPlayer -> Int -> IO ()
set_volume mp vol = I.libvlc_audio_set_volume mp (fromIntegral vol)

get_position :: MediaPlayer -> IO Float
get_position mp = do
  newtyped <- I.libvlc_media_player_get_position mp
  case newtyped of
    CFloat res -> return res

set_position :: MediaPlayer -> Float -> IO ()
set_position mp pos = I.libvlc_media_player_set_position mp (CFloat pos)
