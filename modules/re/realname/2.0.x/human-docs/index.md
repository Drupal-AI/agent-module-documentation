# Real Name — manual setup guide

**Real Name** (`realname`) replaces the name Drupal shows for a user with a
human-friendly display name built from a Token pattern. Instead of showing a
cryptic login username, you can show "Jane Smith" — assembled from the user's
profile fields — everywhere Drupal formats a username: author bylines, comments,
user lists, autocomplete, emails, and notifications.

You define a single site-wide pattern, such as `[user:field_first]
[user:field_last]`, using any `user` Token. Whenever Drupal needs to display a
user's name, the module runs that pattern through the Token system (with inline
Twig support), strips HTML, tidies up spacing, and produces the "real name". To
keep things fast, generated names are cached in a dedicated database table and
only recomputed when a user changes or the pattern changes.

The pattern can reference any user token — profile fields, email, uid, or the
`[user:account-name]` login name as a fallback — but it must **not** reference
`[user:name]`, because that would loop back into name formatting. The module also
ships a bulk action to regenerate everyone's names after you change the pattern,
and exposes the real name as a hidden component on the user display, plus a few
hooks for per-user customization. It depends on the **Token** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (and Token) and
   enable the module.
2. [Configuration](configuration/index.md) — set the name pattern and rebuild
   cached names.

## Where it lives in the admin menu

The settings form sits at **Configuration → People → Real name**
(`/admin/config/people/realname`). Editing the pattern requires the **Administer
realname** permission.

## How to use it

1. Enable the module (and the Token dependency).
2. Go to the settings form and enter a name pattern using the Token browser — for
   example `[user:field_first] [user:field_last]`.
3. Save. New name displays are generated on demand; after changing an existing
   pattern you may want to rebuild the cached names (see
   [Configuration](configuration/index.md)).
