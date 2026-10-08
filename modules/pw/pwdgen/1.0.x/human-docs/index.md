# Password Generator — manual setup guide

**Password Generator** (`pwdgen`) creates **memorable passwords** from a phrase or
a set of words. Rather than producing a random string that is hard to remember, it
builds a password around words you supply and adds symbol and case variation, so
the result keeps some structure you can recall while still being varied. You can
control the length and whether the output includes symbols and/or numbers.

It offers two ways to generate a password: an **admin form** at **Configuration →
People → Generate password** where you type a phrase, choose the properties, and
get a password back on screen; and a **Drush command** for the command line.

The randomness is sound: pwdgen uses PHP's `random_int()` — a cryptographically
secure random number generator — for its selections, so generated passwords have
proper entropy. (One minor implementation note: it also uses `shuffle()` for
reordering, which is not cryptographic, but the meaningful entropy comes from the
`random_int`-based selection.) As with any generated password, the real strength
depends on the length and complexity you choose, so pick settings that give enough
entropy for how the password will be used. The module has no access-control role of
its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the generator form and the symbol
   settings, plus the Drush command.

## Where it lives in the admin menu

The generator lives at **Configuration → People → Generate password**
(`/admin/config/people/generate-password`), and the module's settings route is
`pwdgen.admin_settings`.
