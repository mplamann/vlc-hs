{-# LANGUAGE ForeignFunctionInterface, EmptyDataDecls #-}

module Sound.VLC.Internal where

import Foreign
import Foreign.Ptr
import Foreign.C.Types
import Foreign.C.String

data Instance
data Media
data MediaPlayer

foreign import ccall unsafe "vlc/vlc.h libvlc_new"
    libvlc_new :: CInt -> Ptr CString -> IO (Ptr Instance)

foreign import ccall unsafe "vlc/vlc.h libvlc_media_new_location"
    libvlc_media_new_location :: Ptr Instance -> CString -> IO (Ptr Media)

foreign import ccall unsafe "vlc/vlc.h libvlc_media_player_new_from_media"
    libvlc_media_player_new_from_media :: Ptr Media -> IO (Ptr MediaPlayer)

foreign import ccall unsafe "vlc/vlc.h libvlc_media_release"
    libvlc_media_release :: Ptr Media -> IO ()

foreign import ccall unsafe "vlc/vlc.h libvlc_media_player_play"
    libvlc_media_player_play :: Ptr MediaPlayer -> IO ()

foreign import ccall unsafe "vlc/vlc.h libvlc_media_player_stop"
    libvlc_media_player_stop :: Ptr MediaPlayer -> IO ()

foreign import ccall unsafe "vlc/vlc.h libvlc_media_player_release"
    libvlc_media_player_release :: Ptr MediaPlayer -> IO ()

foreign import ccall unsafe "vlc/vlc.h libvlc_release"
    libvlc_release :: Ptr Instance -> IO ()

foreign import ccall unsafe "vlc/vlc.h libvlc_audio_get_volume"
    libvlc_audio_get_volume :: Ptr MediaPlayer -> IO Int

foreign import ccall unsafe "vlc/vlc.h libvlc_audio_set_volume"
    libvlc_audio_set_volume :: Ptr MediaPlayer -> CInt -> IO ()

foreign import ccall unsafe "vlc/vlc.h libvlc_media_player_get_position"
    libvlc_media_player_get_position :: Ptr MediaPlayer -> IO CFloat

foreign import ccall unsafe "vlc/vlc.h libvlc_media_player_set_position"
    libvlc_media_player_set_position :: Ptr MediaPlayer -> CFloat -> IO ()

