# Configuration

Everything in Add To Head is done through **profiles** on one admin screen. A single
permission, *Administer add to head*, gates all of it.

## Managing profiles

Go to **Configuration → Development → Add To Head**
(`/admin/config/development/add-to-head`). From here you can add, edit, and delete
profiles. Each profile has the following fields:

- **Name** — a machine name (lowercase letters, numbers, and dashes). It identifies
  the profile.
- **Code** — the raw HTML, JavaScript, or CSS to inject. It is inserted **verbatim,
  unescaped** — that is the whole point of the module, and the reason the permission
  is restricted.
- **Scope** — where the code goes (see below).
- **Path visibility** — which pages the profile applies to.
- **Role visibility** — which users (by role) it applies to.

All profiles are stored together in a single configuration object
(`add_to_head.settings`), keyed by each profile's name.

## Scopes — where the code is injected

| Scope | Where it lands |
|---|---|
| **head** | Early in the document `<head>`, before the page's CSS and JS. Use this for `<meta>` tags, verification tags, analytics snippets, and inline `<style>`/`<link>` tags. |
| **scripts** | Near the bottom of the page output (typically close to `</body>`, depending on your theme). Use this for chat widgets and other scripts that belong at the end of the page. |
| **styles** | **Does not currently render anywhere.** The option exists in the form but its implementation is an intentional placeholder, so a `styles`-scope profile is saved but never output. For CSS, use the `head` scope with an inline `<style>` block instead. |

## Path visibility

Choose whether the profile is shown on, or hidden from, a list of paths. Enter one
Drupal internal path per line; `*` is a wildcard and `<front>` matches the front
page.

- **Exclude** (the default) with an **empty** list → shown on **every** page.
- **Exclude** with paths listed → shown everywhere **except** those paths.
- **Include** with paths listed → shown **only** on those paths.
- **Include** with an **empty** list → shown on **no** pages.

## Role visibility

Choose whether the profile is shown to, or hidden from, users with the selected
roles.

- **Exclude** (the default) with **no** roles selected → shown to **everyone**.
- **Exclude** with roles selected → shown to everyone **except** users with those
  roles.
- **Include** with roles selected → shown **only** to users who have at least one of
  those roles.
- **Include** with **no** roles selected → shown to **no one**.

A profile is rendered only when **both** the path check and the role check pass. So,
for example, to run a debugging script only for administrators on the front page:
set scope `scripts`, path visibility **Include** `<front>`, and role visibility
**Include** the *administrator* role.

## After editing via the command line

If you write profiles directly through the config API (rather than the form), clear
caches afterward so the change shows up:

```bash
drush cget add_to_head.settings add_to_head_profiles   # list all profiles
drush cr                                                # clear caches after a raw config write
```

The admin form handles cache clearing for you.

## Permission

| Permission | Machine name | Gates |
|---|---|---|
| **Administer add to head** | `administer add to head` | All four profile screens (overview, add, edit, delete). Flagged security-sensitive because it allows arbitrary markup/JS injection. |

Grant it only to fully trusted roles.
