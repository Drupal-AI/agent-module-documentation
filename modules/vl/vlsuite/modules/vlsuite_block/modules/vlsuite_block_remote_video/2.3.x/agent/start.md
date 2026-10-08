<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Block: Remote Video (vlsuite_block_remote_video) — agent index

Nested submodule of **vlsuite_block**. **Provider-hosted video** (oEmbed) component, via
`vlsuite_media`'s remote video type. Version **2.3.3**. Core `^10.3 || ^11`.

**State the privacy consequence.** The provider's script loads and their cookies are set for every
visitor reaching the page — **before they press play**. On an EU-facing site that needs a lawful
basis and in practice consent; video embeds are among the most common cookie-audit failures. Gate
through the site's CMP (`usercentrics`, `consent_mode`); "privacy-enhanced" modes reduce but do not
eliminate it.

**Performance:** a substantial third-party payload each. Three on a page is slow before your own
code runs — consider lazy-loading or a click-to-load facade.