# Configuration

Custom Configuration is managed from a single list where each entry is one
configuration value, addressable in code by its machine name and optionally varied
by language and domain.

## Open the configuration list

1. Log in as a user with permission to administer site configuration.
2. Go to **Administration → Configuration → System → Custom Configuration**, or
   navigate directly to the module's configuration list
   (`custom_configuration.configuration_list`).

You'll see the list of existing entries with actions to add a new one and to edit
or delete the ones already there.

## Create or edit an entry

When you add (or edit) an entry, you provide:

- **Name** — a human‑readable label for the entry, shown in the list (for example
  *Mobile Number*). This is for administrators; code never uses it to look the value
  up.
- **Machine name** — the stable key you use to read the value in code (for example
  `mobile`). Keep it lowercase and code‑friendly; this is what
  `getValue('mobile')` expects.
- **Value** — the primary value stored for the entry (for example a phone number, a
  key, or a short string).
- **Language** — the language this value applies to. Store one value per language if
  the entry should differ by language; when code requests the value without
  specifying a language, the module returns the value for the currently active
  language.
- **Domain key** — the domain this value applies to, for multi‑domain sites. As with
  language, if code requests the value without a domain key, the module returns the
  value for the currently active domain.
- **Optional values** — a set of extra values you can attach alongside the primary
  one (returned as `value_1`, `value_2`, … by the `getValues()` service). Use these
  when a single entry naturally carries several related pieces of information (for
  example a label, a note, and opening hours next to a phone number).
- **Status (Active / Inactive)** — controls whether the entry returns its value.
  An **inactive** entry returns `null` when accessed, so you can switch a value off
  without deleting it.

## Save

Save the entry and it becomes available immediately to the module's service. If you
mark it inactive later, code reading it will get `null` until you reactivate it.

## Reading values in code

Entries are read through the `custom.configuration` service:

```php
// Primary value for the current language and domain:
$value = \Drupal::service('custom.configuration')->getValue('mobile');

// The full record, including optional values:
$record = \Drupal::service('custom.configuration')->getValues('mobile');
```

Both methods accept optional language‑code and domain‑key arguments if you need a
specific variant rather than the one for the current context. Requesting a machine
name that does not exist — or one that is inactive — returns `null`, so guard for
that in your code.

## A note on secrets

These values are stored as Drupal **configuration**, which is not a secret store and
is typically exported and version‑controlled. Do not put passwords, private API
secrets, or tokens here — use a Key entity or an environment variable for those, and
keep Custom Configuration for non‑sensitive settings.
