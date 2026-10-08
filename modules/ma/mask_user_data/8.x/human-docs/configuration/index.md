# Configuration

Configuring Mask User Data has three parts: **arm the safety flag** so masking is
allowed to run, **define the map** of which user fields become which fake values,
and then **run the masking**. You can do the first two from `settings.php`, from
the module's admin UI, or a mix of both.

> **Before you touch anything:** confirm you are on a non‑production copy of the
> database. Masking overwrites the real values and cannot be undone.

## Step 1 — Arm the safety flag

Enabling the module is intentionally not enough to mask anything. There is a
separate "enable masking" setting that acts as a safety catch, so the module can
never anonymise your users by accident. Set it in `settings.php` (recommended, so
the flag lives with a specific environment) or on the module's admin settings
page. Leave it **off** on any environment where you do not want masking to run.

## Step 2 — Define the field‑to‑Faker map

The map pairs each user field or property with a **Faker** function that generates
a plausible fake value for it. For example, the `mail` property maps to Faker's
`email`, and a `field_phone` field maps to `phoneNumber`. Anything you do not list
is left untouched.

You can define the map two ways:

- **In `settings.php`** using the module's map array, for example:

  ```php
  $conf['mask_user_data_map_array'] = [
    'mail' => 'email',
    'field_phone' => 'phoneNumber',
    // 'field_name' => 'name', etc.
  ];
  ```

  Keeping the map in `settings.php` is handy when you want it version‑controlled
  or environment‑specific.

- **Through the admin UI**, where the same field‑to‑function pairs can be entered
  in a form. Use whichever fits your workflow; the two describe the same map.

Match each field to a Faker function that produces the right *shape* of data (an
email for an email field, a phone number for a phone field) so the masked copy
still behaves realistically for testing.

## Step 3 — Run the masking

Once the safety flag is armed and the map is defined, run the masking one of three
ways:

- **Drush:** `drush mud` — the quickest way to mask on demand.
- **Cron:** let a scheduled cron run trigger the masking.
- **The UI:** trigger the masking action from the module's admin page.

After it runs, spot‑check a few user accounts: the names, emails and mapped fields
should now hold fake — but realistic — values, while the accounts otherwise work
normally.
