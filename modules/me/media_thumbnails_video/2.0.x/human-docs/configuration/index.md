# Configuration

Media Thumbnails Video needs to know how to run FFmpeg. Its one settings form
covers the binary locations and a couple of performance options. In many setups
the defaults work as-is (FFmpeg auto-detected), so you may only need this page if
the binaries live somewhere unusual or you want to tune performance.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Media → Media thumbnails video settings**, or navigate
   directly to `/admin/config/media/media-thumbnails-video-settings`.

## The settings

### FFmpeg binary path

The full path to the `ffmpeg` executable (for example `/usr/bin/ffmpeg`). **Leave
it empty to auto-detect** — the library will try to find FFmpeg on the system
PATH. Set an explicit path only when FFmpeg isn't on the PATH or you need a
specific build.

### FFprobe binary path

The full path to the `ffprobe` executable (for example `/usr/bin/ffprobe`), which
FFmpeg uses to inspect video files. As with FFmpeg, **leave it empty to
auto-detect**, or set an explicit path if needed.

### Timeout

How long, in seconds, FFmpeg is allowed to run before it times out. The default
is **3600** (one hour). Raise it if you process very large or long videos and see
timeouts; lower it if you'd rather fail fast.

### Threads

How many threads FFmpeg may use. The default is **12**. Increase it on a powerful,
dedicated server to speed up generation, or decrease it on shared or resource-
constrained hosting to keep FFmpeg from overloading the server.

Click **Save configuration** when done.

## After changing settings

Changing these values affects future thumbnail generation. To apply them to
videos that already have thumbnails, re-generate their thumbnails through the
**Media Thumbnails** framework (for example by re-saving the media entities or
using the framework's regeneration tooling).

## If thumbnails aren't appearing

The most common cause is FFmpeg not being found or runnable. Confirm the `ffmpeg`
and `ffprobe` binaries are installed and reachable (either on the PATH, or via
the explicit paths above), and that PHP's GD extension is enabled. If FFmpeg
can't be located, no thumbnail is produced.
