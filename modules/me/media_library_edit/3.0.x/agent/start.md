# media_library_edit — agent start

Adds a per-item **Edit** button to the core `media_library_widget` (media entity-reference
fields), opening the media edit form in an AJAX modal. Configured entirely through
**third-party widget settings** on a form display — no admin route, no `configure` key, no
permissions of its own. Enable it under **Manage form display → media field settings**.

- Turn on the edit button + pick a form mode (widget settings, config schema, behavior) → [configure/media_library_edit.md](configure/media_library_edit.md)
