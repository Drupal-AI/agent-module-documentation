<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Clone — agent index

Pre-fills an entity **add form by cloning field values from a source entity** via a `?fieldclone=` URL
parameter (`node:17:field_common`, or `:field_source:field_target`). Depends on `replicate`. Config at
`fieldclone.information`. Version **8.x-1.0**. Core `^8.7.7||^9||^10||^11`.

**Access-checked (correct):** verifies the current user's **view access to the source entity AND field**
before copying — the URL parameter can't read values from inaccessible entities/fields. Authoring
convenience; no info-disclosure.
