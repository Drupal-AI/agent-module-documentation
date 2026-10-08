<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Visibility — agent index

Keeps **public files of a not-yet-public entity in the PRIVATE filesystem** until the entity becomes
publicly accessible — closes the classic *"unpublished node's public image is still downloadable by URL"*
leak (file access follows entity access, via Drupal's access system). Depends on core `file`;
`file_visibility_track_usage` submodule. Version **1.0.0-alpha9**. Core `^10.4||^11`.

**Positive security control.** Ensure the private filesystem is configured + served via access-checked
delivery; verify the access mapping matches intent; test against your workflow.
