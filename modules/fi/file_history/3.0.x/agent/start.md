<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File History — agent orientation

D10 module: Form API element `file_history` (`src/Element/FileHistory.php`) + field widget (`src/Plugin/Field/FieldWidget/FileHistoryWidget.php`) retaining upload history; download controller.

- Download route `/file_history/download/{file}` (`FileHistoryDownloadController::downloadFile`), permission `download file histoy files`, param `file` upcast to `entity:file`.
- SECURITY FINDING (D2): `downloadFile()` does `realpath()` + `file_get_contents()` on the file entity and streams it with NO per-file access check (`$file->access('download')` is never called). Any holder of the single `download file histoy files` permission can download ANY file entity on the site by iterating the fid — including private/other-users' managed files. Fix: check `$file->access('download')` (or scope to file_history-managed files) before serving.
- Test submodule `test_file_history` is example code only.
