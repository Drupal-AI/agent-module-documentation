<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Penpot (ai_penpot) — agent index

Reads a **Penpot** design's context over the Penpot **RPC API** (`<base>/api/rpc/command/<command>`)
from server-side PHP and exposes it to Drupal **AI Agent** tools, so the Drupal Canvas AI
assistant can build from a real design. Package `AI`. Core `^11.2`. PHP `>=8.3`. Version
`1.0.0-alpha1`. License GPL-2.0-or-later.

- **Depends on** (all required): `ai`, `ai_agents`, `key`, `easy_encryption`. Optional integration:
  `ai_context` (seeds editable guidance items when present).
- **Settings, config object, Key/token, base URL, install wiring** →
  [config/settings.md](config/settings.md)
- **The two AI Agent tools and the PenpotContextClient service** →
  [tools/ai-agent-tools.md](tools/ai-agent-tools.md)

## What it provides (from source)

- **Service `ai_penpot.client`** (`src/PenpotContextClient.php`): fetches and summarizes Penpot
  design context. Sends the token in an `Authorization: Token` header, content-negotiates JSON
  (`Accept: application/json`) against the RPC endpoint. Methods: `fetchFile()` (get-file),
  `fetchPage()` (get-page), `listDesignPages()`, `resolvePageIdByName()`, `summarizeTokens()`,
  static `parsePenpotUrl()` (extract file/page UUIDs from a workspace/view link), `getToken()`,
  `getBaseUrl()` (validates http(s)+host), `getDefaultFileId()`.
- **Service `ai_penpot.installer`** (`src/AiPenpotInstaller.php`): on install creates the `penpot`
  Key and (when `ai_context` is present) seeds three AI Context items from config.
- **Two AI function-call plugins** (`src/Plugin/AiFunctionCall/`), group `information_tools`:
  - `ai_penpot:list_design_pages` (`PenpotListDesignPages`) — lists a file's pages with ids.
  - `ai_penpot:design_context` (`PenpotDesignContext`) — reads one page's colours, typography,
    verbatim text and shape outline; output is YAML for the agent.
- **Settings form** `SettingsForm` at route `ai_penpot.settings` — `/admin/config/ai/penpot`.
- **Permissions** (`ai_penpot.permissions.yml`): `administer ai penpot` (route + token config),
  `use ai penpot design context` (run the tools). Both `restrict access: true`.
- **Config**: object `ai_penpot.settings` with schema (`config/schema/ai_penpot.schema.yml`) and
  install defaults (`config/install/ai_penpot.settings.yml`).
- **Install/requirements** (`ai_penpot.install`): provisions the Key, seeds context items, and a
  runtime requirement warns when the base URL or token is unset.

## Mechanism (short)

The tools take a Penpot link (or a file id + page id/name). `parsePenpotUrl()` pulls the file/page
UUIDs from the link (it is used only to extract ids — never fetched as a URL). The client always
POSTs to the **admin-configured** base URL's RPC endpoint. `summarizeTokens()` walks the page's
flat shape map: solid fills become hex colours, text shapes yield typography styles and the real
text runs, named shapes form an outline. The result is dumped as YAML and returned to the agent.
No SVG/XML/archive parsing, no browser, no interactive login.
