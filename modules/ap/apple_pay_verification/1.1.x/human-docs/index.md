# Apple Pay Verification — manual setup guide

**Apple Pay Verification** (`apple_pay_verification`) handles one specific chore in
setting up Apple Pay on the web: serving Apple's **merchant domain-verification
file** at the exact well-known path Apple expects. To enable Apple Pay on a domain,
Apple fetches a verification file from
`/.well-known/apple-developer-merchantid-domain-association` (or the `.txt`
variant); this module lets an administrator upload that file and serves it at that
path automatically.

It provides an admin **upload form** and its own permission. The serving is
implemented safely: the controller serves the **admin-uploaded managed file** at
**fixed** well-known routes — there is no request parameter or path in the route,
so there is no path-traversal or arbitrary-file exposure. The routes are public
(anyone can fetch the file), which is correct: Apple must be able to retrieve the
verification file anonymously. Only administrators holding the module's permission
can upload or replace the file, and the module has no other access-control role.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. Obtain the domain-verification file from Apple (from your Apple Pay merchant
   configuration).
2. Log in as an administrator with the module's upload permission and open the
   module's upload form (in the Commerce/admin configuration area).
3. Upload the file. The module stores it as a managed file and immediately serves
   it at `/.well-known/apple-developer-merchantid-domain-association` (and the
   `.txt` path).
4. Complete domain verification in Apple's Apple Pay setup — Apple will fetch the
   file from your domain to verify it.

If Apple ever issues a new verification file, upload the replacement through the
same form; the fixed well-known routes will serve the new file.
