# Signature — manual setup guide

**Signature** (`signature`) gives your users a personal **signature** — a small
piece of text or HTML they set once and that gets shown with what they post. It is
the classic forum-style signature: rather than typing a sign-off at the bottom of
every comment, a user stores it in their profile and the module appends it for
them. Note that its machine name is `signature`; do not confuse it with the
`sign_widget` or `signaturefield` modules, which capture *drawn* signatures on a
canvas — this one is plain text.

Because the signature lives on the user profile, changing it updates it everywhere
at once — edit it once and every past and future post shows the new version. The
module also lets you decide which content types (and their comments) show
signatures at all, and it can style signatures differently from the surrounding
post. If signatures are turned off for every content type, the signature field
simply disappears from the profile form.

The module has no dependencies and no submodules. It is a lightly maintained,
long-standing module, and note that it is **not covered by Drupal's security
advisory policy**. One thing to keep in mind: a signature is **content the user
types**, and it is displayed to other people, so make sure it is filtered through
a restricted text format — otherwise a user could inject a script through their
signature (stored cross-site scripting). Signatures may also contain personal
data. The module itself plays no access-control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, each user gets a **Signature** field on their profile edit form
where they type their signature text or HTML. As an administrator you control
where signatures appear — which content types and comments display them — and you
can give signatures their own styling. The key setup step is making sure the
signature is rendered through a **restricted text format** so that user-supplied
HTML cannot include active scripts.
