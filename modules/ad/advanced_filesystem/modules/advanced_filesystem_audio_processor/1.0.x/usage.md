Process Drupal managed audio files with FFmpeg — probe metadata, render waveform images, and produce trimmed, converted, normalized, metadata-stripped and channel-split derivatives.

---

Advanced Filesystem: Audio Processor is an optional submodule of the Advanced FileSystem project. It wraps the system's `ffmpeg` and `ffprobe` binaries in a Drupal service (`AudioProcessorService`) and exposes them over managed audio files. On processing, it extracts full metadata (duration, bitrate, sample rate, channels, codec, and ID3/Vorbis tags such as title/artist/album/year/genre) into the `adfs_audio_jobs` table and renders a waveform PNG. On demand it produces derivatives — trim to a `[start, end]` range, convert to mp3/aac/flac/ogg/wav, apply EBU R128 two-pass loudness normalization, strip embedded metadata for privacy, or split a stereo file into two mono files — each recorded in `adfs_audio_derivatives`. Processing can be triggered automatically when an audio file is uploaded (queued via cron) or manually from per-file admin tabs, a batch form, and a dashboard that reports disk usage and offers cleanup/reprocess actions. A `media` source plugin is registered for audio. Binary paths and behaviour are configured at `/admin/config/media/advanced_filesystem/audio-processor`, and all routes require the module's restricted administer permission.

---

- Extract technical metadata (duration, bitrate, sample rate, channels, codec) from uploaded audio files.
- Read ID3/Vorbis tags (title, artist, album, year, genre) into a queryable Drupal table.
- Render a waveform PNG for each track to display on the file's admin page.
- Auto-process every uploaded `audio/*` file in the background via cron queue.
- Trim a track to a specific `[start, end]` time range without re-encoding (stream copy).
- Convert audio between mp3, aac, flac, ogg and wav with a chosen bitrate.
- Apply broadcast-standard EBU R128 loudness normalization (two-pass, default −23 LUFS).
- Strip ID3/Vorbis metadata from a file for privacy/compliance before redistribution.
- Split a stereo recording into separate left and right mono files.
- Batch-process a large existing library of audio files from one admin form.
- View a dashboard of processing coverage, disk usage and per-file status.
- Clean up derivatives older than N days to reclaim disk space.
- Requeue failed jobs for reprocessing in one click.
- Delete an individual derivative and its file from the file's edit tab.
- Export a derivative as a new Drupal-managed file for reuse elsewhere.
- Confirm at a glance whether `ffmpeg`/`ffprobe` are installed and executable (system status check).
- Use audio files as a dedicated Media source type in the media library.
- Configure custom `ffmpeg`/`ffprobe` binary paths for non-standard server layouts.
- Point waveform width/height/colour and cleanup retention at site-specific values via config.
- Keep processing outputs in a per-file public derivatives directory tied to the source FID.
