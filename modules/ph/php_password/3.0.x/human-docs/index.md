# PHP Password algorithm — manual setup guide

**PHP Password algorithm** (`php_password`) lets you choose which algorithm Drupal
uses to hash user passwords — **argon2id**, **argon2i**, or **bcrypt** — on versions
of Drupal core that don't yet expose that choice. It is a small
forward‑compatibility layer: it adds no hashing code of its own, it simply tells
core's existing password service which algorithm and options to use, and the actual
hashing is done by PHP's native, memory‑hard `password_hash()` implementation. That
means the hashes it produces carry the standard PHP prefixes and stay verifiable by
Drupal core.

The important thing to know is **whether you even need it**. The 3.x version is a
bridge for sites on Drupal core **10.4/10.5 and 11.1/11.2**, where the password
service does not yet accept an algorithm. From **Drupal 11.3 onward** core supports
this natively, so on those versions the module cleanly does nothing — it detects that
core already handles it and stays out of the way. On the versions where it is
needed, enabling it plus a couple of lines of configuration is all it takes.

Configuration is done through **container parameters in a `services.yml` file**, not
through an admin form — so this is a code/deployment change, described below, rather
than a point‑and‑click setting.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no admin configuration page** — you set the algorithm in a `services.yml`
file, described in "How to configure it" below.

## How to configure it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Create or edit a services file — typically `sites/default/services.yml` — and set
   the password parameters:

   ```yaml
   parameters:
     password.algorithm: argon2id
     # Optional: tune the hashing cost/options passed to password_hash().
     password.options:
       memory_cost: 65536
       time_cost: 4
       threads: 1
   ```

   - **`password.algorithm`** — one of `argon2id` (a strong, recommended default),
     `argon2i`, or `2y` (bcrypt).
   - **`password.options`** — optional; the option array PHP's `password_hash()`
     accepts for the chosen algorithm (memory/time/threads for argon2, or `cost` for
     bcrypt).
3. Make sure the file is loaded (if you use a custom services file, register it via
   `$settings['container_yamls']` in `settings.php`), then rebuild the container
   (`drush cr`).

Existing password hashes are upgraded gradually: each user's hash is re‑hashed with
the new algorithm the next time they log in.

> **Two caveats.** Choosing a weak algorithm or misconfigured options would *weaken*
> hashing, so stick to argon2id unless you have a reason not to. And argon2 requires
> PHP to be built with libargon2 — confirm your PHP has it before switching. You can
> verify the active algorithm by inspecting a freshly generated hash with PHP's
> `password_get_info()`.
