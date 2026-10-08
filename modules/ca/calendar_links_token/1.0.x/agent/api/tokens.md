<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `calendar_links` token

All logic lives in `calendar_links_token.module`. There is no route, form, service, plugin,
permission or config object — just two token hooks and one helper.

## Declaration — `calendar_links_token_token_info()`

- Adds token **type** `calendar_links` (name "Calendar links").
- Adds one token `calendar_links['parameters']` marked `'dynamic' => TRUE`, so everything after
  `parameters:` in the token string is passed through as the argument payload.

## Replacement — `calendar_links_token_tokens($type, $tokens, $data, $options, $bubbleable_metadata)`

- Runs only when `$type == 'calendar_links'`.
- For each requested token name: `$parameters = str_replace('parameters:', '', $name);` then
  `$links = _calendar_links_token_generate_links($parameters);`.
- If non-empty, `$replacements[$original] = Markup::create($links);` (the helper's HTML is emitted
  as safe markup — see "Output" below for what actually goes into it).

## Grammar

```
[calendar_links:parameters:nid|start|end|title|description|location]
```

`_calendar_links_token_generate_links()` does `explode('|', $parameters)` and **requires exactly 6
fields** (`if (count($fields) != 6) return '';`). The first is the node id; the remaining five are
start, end, title, description, location.

## Field-name vs literal resolution

1. `$nid = array_shift($fields);` then
   `$node = \Drupal::entityTypeManager()->getStorage('node')->load($nid);` (wrapped in try/catch;
   errors are logged to the `calendar_links_token` channel and abort with an empty string).
2. If `$node` is set, each of the five remaining args is resolved:
   - If `$node->hasField($field)` → use the node's value. For a field whose type is `datetime`,
     it takes `$node->get($field)->date->getPhpDateTime()` (a `DateTime` object); otherwise
     `$node->get($field)->value` (a string).
   - If the node has **no such field** → the argument is used **verbatim as a literal string**.
   So `title|body|field_venue` pulls node values, while `Event A|Details|Main St 12` are literals,
   and the two can be mixed.
3. Start/end: if the resolved value is already a `DateTime` object it is used directly; otherwise it
   is parsed with `new DateTime($value, new DateTimeZone($site_timezone))` where `$site_timezone`
   is `\Drupal::config('system.date')->get('timezone')['default']` (the site default timezone).
   Title/description/location are cast with `strval()`.

If `$node` does not load (bad/unknown nid, or a non-node id), the function returns an empty string
and **no output and no file are produced** — the node must load for anything to happen.

## Building the links (spatie/calendar-links)

```
$link = Link::create($title, $start, $end)->description($description)->address($location);
$google_link      = $link->google();
$yahoo_link       = $link->yahoo();
$web_outlook_link = $link->webOutlook();
$ics_data         = base64_decode(str_replace('data:text/calendar;charset=utf8;base64,', '', $link->ics()));
```

- The Google/Yahoo/Outlook methods return hosted calendar URLs; the library `urlencode()`s the
  title/description/location into the query string.
- The `.ics` payload is decoded from the library's data-URI and written to disk:
  `\Drupal::service('file_system')->saveData($ics_data, "public://invite_$nid.ics", $file_exists)`
  where `$file_exists` is `FileExists::Replace` (or, pre-10.3, `FileSystemInterface::EXISTS_REPLACE`
  via `DeprecationHelper::backwardsCompatibleCall`). The URL is then
  `\Drupal::service('file_url_generator')->generateAbsoluteString($ics_uri)` with `'?' . time()`
  appended as a cache-buster. The file is (re)written to the **public** filesystem on every render.

## Output

The helper returns a `<p>` containing four links, wrapped by the caller in `Markup::create()`:

```
📅 <a href='$google_link'>Google</a>
 | <a href='$yahoo_link'>Yahoo</a>
 | <a href='$web_outlook_link'>Outlook.com</a>
 | <a download='invite_$nid.ics' href='$ics_link'>iCal & Outlook</a>
```

The visible link text is fixed ("Google", "Yahoo", …); the event's title/description/location
appear only inside the (url-encoded) hosted-calendar URLs and inside the generated `.ics` file, not
as raw link text.

## Operating notes

- Enable: `drush en calendar_links_token`. Nothing to configure.
- Place the token where token replacement runs — the module's documented use case is a webform
  event-registration confirmation/notification email, but it works in any tokenized text
  (node fields, Views rewrite, mail bodies).
- The library dependency is `spatie/calendar-links` (`Spatie\CalendarLinks\Link`); install the
  module via Composer so it is present.
- Failures inside link generation (e.g. an unparsable date string) are caught and logged to the
  `calendar_links_token` logger; the token then resolves to nothing.
