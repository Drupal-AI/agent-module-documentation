<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# waveform entity + WaveformJsonService

## `waveform` content entity

`src/Entity/Waveform.php` — `#[ContentEntityType(id: "waveform", base_table: "waveform")]`, entity
key `id` only. Base fields (`baseFieldDefinitions`):

- `id` (integer, read-only)
- `audio_fid` (integer, required) — the source audio file id
- `waveform_fid` (integer, required) — the generated peaks `File` id

No routes, forms, list builder, or access handler — it is an internal bookkeeping entity mapping an
audio file to its cached peaks JSON. `preDelete()` deletes the referenced `waveform_fid` `File` when
a `waveform` entity is deleted.

## `WaveformJsonService`

Service id `audio_wavesurfer.waveform_json_service` (`audio_wavesurfer.services.yml`, arg
`@entity_type.manager`). `src/Services/WaveformJsonService.php`. Holds the `waveform` entity storage.

### `buildWaveformJson(int $fid): void`

Called from `audio_wavesurfer_build_waveform()` on `media` insert/update when
`waveform_options.waveform_storage` is on.

1. `File::load($fid)`, take `getFileUri()`.
2. `generateAudioWaveform($uri)` → array of normalized peak floats.
3. Compute sidecar target `<dirname>/<filename>.json` next to the audio file; `realpath` it.
4. Query the `waveform` storage for an existing row with `audio_fid == $fid` (accessCheck TRUE).
5. `file_system->saveData(json_encode($waveform), $filepath_real, EXISTS_REPLACE)`.
6. If no existing row: create a managed `File` (`uri` = target, `status` = 1), save it, then create
   the `waveform` entity (`audio_fid`, `waveform_fid`) and save. (Existing rows only rewrite the
   JSON file; the entity is not updated.)

### `generateAudioWaveform(string $filepath): array` (private)

- Points = `waveform_options.waveform_points` (default 1000).
- Duration from `getAudioDuration()`, then `asetnsamples = (duration * 22050) / points`.
- Runs, via `shell_exec`, with the file path passed through **`escapeshellarg`**:
  ```
  ffprobe -f lavfi -i amovie=<arg>,aresample=22050,asetnsamples=<n>,astats=metadata=1:reset=1 \
    -show_entries frame_tags=lavfi.astats.Overall.RMS_level -of json
  ```
- Parses the JSON frames' RMS_level values, converts dB → linear (`pow(10, db/20)`), normalizes to
  0..1 against the 95th-percentile max, then `removeNoiseOnArrayBorder()` zeroes leading/trailing 1s.

### `getAudioDuration($file_path): float` (private)

`ffprobe -i <escapeshellarg(path)> -show_entries format=duration -v quiet -of csv='p=0'` via
`shell_exec`; throws `InvalidArgumentException` if the file is missing.

### `getAudioWaveformStored(int $fid): array|null`

Looks up the `waveform` row for `audio_fid == $fid`, loads its `waveform_fid` `File`, and
`json_decode(file_get_contents($uri))` of the sidecar JSON. Returns the peaks array (or NULL). Used
by the formatter when "Waveform Usage" is enabled.

## Operating notes

- FFmpeg (`ffprobe`) must be on `PATH`; peaks are generated at media save time, once per file
  (subsequent saves rewrite only the JSON, keyed by `audio_fid`).
- The sidecar `.json` lives beside the audio file in the same stream wrapper directory and is
  tracked as a managed `File` + `waveform` entity so it can be cleaned up on entity delete.
- The `media` delete hook is a documented `@todo` no-op — deleting an audio media item does not
  currently purge its `waveform`/JSON (orphaned rows/files can accumulate). This is a housekeeping
  gap, not a security issue.
