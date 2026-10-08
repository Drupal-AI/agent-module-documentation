<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Book Access Code - agent index

**Book Access Code** gates core Book node pages behind admin-defined access codes (session-stored grant). Version **2.0.1** (`2.0.x`). Core `^9.2 || ^10`. Depends on `book`, `node`.

## Key files
- `src/EventSubscriber/KernelEventsSubscriber.php` - enforces the gate on `entity.node.canonical`.
- `src/BookAccessCodeManager.php` - `accessCodeAppliesToBook()` uses strict `in_array(...,TRUE)`; `sendAccessDenied()` builds the redirect.
- `src/Form/BookAccessCodeForm.php` - the `/book_access` code-entry form.
- `src/Entity/AccessCode.php` - the code config/content entity.

## Security notes
- Code comparison is strict (no type juggling) - not trivially bypassable.
- Gate only applies to the canonical node route; JSON:API/REST/Views are not covered.
- `sendAccessDenied()` calls `$response->send()` directly instead of `$event->setResponse()` - see campaign report (env-dependent).