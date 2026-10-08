# Configuration

Asset Purge Manager's job is to find unused assets and delete them. Because that
deletion is **permanent**, the important part of "configuring" it is doing so
safely.

## Who can run it

Purge access is controlled by the module's permission. Grant it under
**People → Permissions** (`/admin/people/permissions`) only to trusted
administrators — anyone with it can permanently remove files.

## Run a purge safely

1. **Back up your files first.** The files this module deletes cannot be
   recovered from within Drupal. Take a backup of your files directory (and,
   ideally, the database) before running a purge.
2. **Review what will be removed.** Look at the list of assets the module has
   identified as unused *before* confirming. This is the single most important
   step — it is your chance to spot anything that is actually still needed.
3. **Watch for references the scan can't see.** An asset counts as "unused" only
   according to what the scan checks. Files referenced from custom code, external
   systems, serialized data, or unusual field setups may not be detected and could
   be flagged as unused when they are not. If in doubt, leave it.
4. **Try it on staging first.** Run a purge against a copy of the site and confirm
   nothing breaks before doing it on production.
5. **Then confirm the purge.** Once you are satisfied with the list, run it. The
   selected assets are deleted and storage is reclaimed.

## After purging

Spot‑check pages and content that referenced media to confirm nothing lost an
image or file it needed. If something did break, restore the affected files from
the backup you took in step 1 — which is why that step is not optional.
