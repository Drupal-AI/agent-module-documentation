Media File Delete adds an "Also delete the associated file?" option to the media delete flow so that removing a media item can also remove its underlying file from the file system, instead of leaving an orphaned file behind.

---

By default Drupal only deletes the `media` entity when you delete it; the referenced `file` entity (and the physical file) is left in place. Media File Delete alters the media entity type so its `delete` and `delete-multiple-confirm` forms are replaced with the module's own forms (via `hook_entity_type_alter`), which append an optional checkbox to also delete the associated source file. When the box is ticked, the module deletes the `file` entity after the media is deleted. Deletion is guarded: it only offers the option for file-based media sources, it respects file-entity delete access (files owned by other users are retained unless the actor has the `delete any file` permission granted through the module's custom file access handler), and it refuses to delete a file that is still used elsewhere according to a chained file-usage resolver (core's `file.usage` by default, extendable with tagged services). A settings form at **Admin → Configuration → Media → Media File Delete Settings** sets whether the checkbox defaults to on (`delete_file_default`) and whether editors may change it at all (`disable_delete_control`). The bulk delete form applies the same checks per item and reports how many files were deleted, skipped for insufficient privilege, or skipped because they are in use. A submodule, Media File Delete - Entity Usage, plugs the Entity Usage module into the resolver chain so files still referenced by tracked entities are also protected.

---

- Delete a media item and its underlying file in one step, avoiding orphaned files.
- Offer content editors an opt-in "Also delete the associated file?" checkbox on the media delete confirm form.
- Default that checkbox to on site-wide via the `delete_file_default` setting.
- Force a site policy by hiding the checkbox with `disable_delete_control` (editors get the admin default, no choice).
- Bulk-delete multiple media items and clean up their files together from the media library/admin list.
- Keep a file that is referenced in other places (usage > 1) instead of breaking those references.
- Retain a file owned by another user unless the actor may delete it.
- Grant trusted roles the `delete any file` permission so they can remove files they do not own.
- Restrict who can change deletion behavior with the `administer media file delete` permission.
- Reclaim disk space when retiring old media assets.
- Prevent orphaned files accumulating after routine editorial cleanup.
- Only act on file-based media (image, document, audio, video); other sources are untouched.
- Get a confirmation message naming the file that was deleted.
- See warnings on bulk delete counting files skipped because they are in use or inaccessible.
- Protect files still referenced by tracked entities by enabling the Entity Usage submodule.
- Extend usage detection with a custom tagged file-usage resolver service.
- Log deleted-file events to the `media_file_delete` logger channel during bulk deletion.
- Deploy deletion defaults as configuration (`media_file_delete.settings`) between environments.
- Let editors delete media without the physical file when they leave the checkbox unticked.
- Integrate cleanly with core file usage so shared files across media are never accidentally removed.
