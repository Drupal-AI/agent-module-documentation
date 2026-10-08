# Configuration

Domain Microsite adds no settings page of its own. A microsite is just a Domain
record with a few extra fields, so you configure it on the normal domain record
form.

## Before you start

At least one **regular domain record must already exist** — a microsite lives
underneath a parent domain. If you have not created any domains yet, add a normal
one first under **Configuration → Domain**, then come back.

## Create a microsite

1. Go to **Configuration → Domain** (`/admin/config/domain`) and click to add a
   new domain record (or edit an existing one you want to convert).
2. Tick **Make domain microsite**.
3. Fill in the two microsite fields this reveals:
   - **Parent domain** — the existing domain the microsite sits under (for
     example `example.com`). The microsite is reached at this parent's hostname
     plus its base path.
   - **Base path** — the sub-path segment that identifies the microsite, e.g.
     `microsite`, giving `example.com/microsite`.
4. **Ignore the Hostname and Machine name fields.** The module overrides these
   with auto-generated identifiers for microsites, so whatever you type there is
   replaced.
5. **Save** the record.

The sub-path now behaves like a domain: requests to it set the microsite as the
active domain, and generated links within it are prefixed with the base path
automatically.

## Things to keep in mind

- **Access is still Domain's job.** Assigning content to the microsite and
  controlling who sees it works through Domain / Domain Access exactly as for any
  domain. Verify the mapping matches the content isolation you want.
- **Field labels are not rewritten.** To stay lightweight, the module does not
  alter form field labels to show the microsite URL. Some path settings elsewhere
  in Drupal display a site URL before the field; enter path values *relative* to
  the microsite regardless of the label shown. (The Domain records page itself is
  the one exception where the URL is adjusted.)
- **Route caching.** Domain's route caching does not fully cooperate with
  microsites; if routes behave oddly, see the Domain issue and patch referenced on
  the [project page](https://www.drupal.org/project/domain_microsite).
