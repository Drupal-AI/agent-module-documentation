# Configuration

Email Validator Customizer has one settings form where you decide whether to replace
core's email validator and how strict the replacement should be.

## Permission

The settings form is gated by the **administer evac configuration** permission, which
is a restricted permission — keep it on trusted administrator roles only. Grant it
under **People → Permissions**.

## Settings form

Go to **Configuration → Email Validator Customizer** (`/admin/config/evac`). The form
writes to the `evac.settings` configuration:

- **Replace core's email validator** (`replace`, default **on**) — when on, the
  chosen validation below replaces Drupal's default email validation site-wide.
  Uncheck it to leave core validation intact and only use the validator services in
  your own code.
- **Replacement validation** (`replacement`, default **DNS check**) — which
  validation replaces core when replacement is on. The choices are:
  - **DNS check** — requires the email's domain to exist and have MX records. This
    is the default and rejects throwaway or malformed domains that pass an RFC-only
    check.
  - **Spoof check** — detects confusable/homograph characters. Requires the PHP
    `intl` extension.
  - **Message-ID** — validates Message-ID style addresses.
  - **No RFC warnings** — fails addresses that merely produce RFC warnings.
  - **Multiple with AND** — combine several validations that must **all** pass (see
    below).
- **Sub-validations for "Multiple with AND"** (`multiple_with_and`) — only used when
  the replacement is **Multiple with AND**. Tick which validations must all pass:
  DNS check, spoof check, Message-ID, no-RFC-warnings, and RFC (core's own rule). By
  default DNS check and spoof check are enabled.
- **Log errors** (`log_errors`, default off) — log rejected addresses to the `evac`
  logger channel, useful for debugging registration problems.
- **Log warnings** (`log_warnings`, default off) — also log RFC warnings (only takes
  effect when *Log errors* is on).

> **Logging caution.** The logging options record submitted email addresses, so they
> aren't recommended for production — turn them on only while debugging.

## After changing settings

If you toggle *Replace core's email validator*, rebuild the cache (`drush cr`) so the
core service swap is re-evaluated. Changes to the chosen validation or sub-validations
take effect on the next request without a rebuild, since the replacement reads the
config at runtime.

## Safe fallback

If replacement is disabled, or the configured validator can't be found, the module
falls back to Drupal's own core email validation — it fails safe to core behaviour,
not to accepting everything.
