<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Access Fix fixes files' public/private location according to their parent entities' access for anonymous users, keeping files of non-public entities private.

---

File Access Fix moves files between the public and private filesystem based on whether their parent
entities are accessible to anonymous users — closing the leak where a file (image, document) attached to a
non-public entity, when stored in the public filesystem, is directly downloadable by URL despite the entity
not being viewable. It checks each file's usages: if no using entity/field grants anonymous access (and
`hook_file_download` doesn't allow it), the file is moved to **private** storage; if anonymous access is
allowed, it may be public. It depends on core File.

This is a positive security control — it makes attached-file visibility follow the parent entity's
anonymous-access state, preventing the classic "unpublished node's public image is still fetchable" leak.
When adopting: ensure the **private filesystem is configured** (and served through Drupal's access-checked
file delivery), and test it against your content workflow (which entity states count as anonymously
accessible). It provides file-access enforcement, so verify the mapping matches your intent.

---

- Move files private when the parent isn't public.
- Follow parent-entity anonymous access.
- Close the public-file leak of hidden entities.
- Check file usages for anonymous access.
- Move to private when no anon access.
- Keep public when anon access allowed.
- Depend on core File.
- Ensure the private filesystem is configured.
- Serve private files access-checked.
- Test against your content workflow.
- Apply a positive security control.
- Verify the access mapping.
- Respect hook_file_download denials.
- Prevent direct download of hidden files.
- Enforce file visibility.
- Follow entity access for files.
- Protect attached files.
- Handle file location by access.
- Close the unpublished-image leak.
- Move files by parent access.
