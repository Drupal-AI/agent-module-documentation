<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Lunr — agent index

Search API backend for **Lunr** (client-side/in-browser search — index served to the browser, no server
query). Depends on `search_api`, `jquery_ui_autocomplete`. Version **3.1.0**. Core `^10.2||^11`.

**Security:** the Lunr index is **served to the client** (fully downloadable) — **only index content safe
to be fully public**; never index access-restricted content into a client-side index. Confirm the index is
public.
