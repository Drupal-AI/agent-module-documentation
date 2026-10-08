<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feeds Textarea Fetcher lets import data be pasted in a textarea.

---

Feeds Textarea Fetcher provides a **Feeds fetcher where the data to import is pasted into a textarea** —
instead of fetching from a URL or upload, the importer takes content the user pastes (stored to a configured
directory) and feeds it into the Feeds pipeline. It depends on the Feeds and core File modules.

Use it for quick paste-based imports. It is an import/Feeds feature run by privileged users. Security note:
because data is **pasted by the operator** (not fetched from a URL), there is **no server-side-request/SSRF
surface** here — the trust is simply that the operator pastes valid/trusted content; the Feeds processor then
handles it under normal Feeds privileges. It has no access-control role. Configure the textarea fetcher on a
feed type.

---

- Fetch import data from a textarea.
- Take pasted content.
- Feed it into the Feeds pipeline.
- Depend on Feeds and core File.
- Serve import.
- Avoid URL/upload fetching.
- Have NO SSRF surface (data is pasted).
- Trust the operator's pasted content.
- Process under normal Feeds privileges.
- Have no access-control role.
- Configure the fetcher on a feed type.
- Handle textarea import.
- Paste data.
- Configure the fetcher.
- Import pasted data.
- Handle the import.
- Feed content.
- Paste imports.
- Trust the operator.
- Provide a textarea fetcher.
