<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Outbound — agent index

A link **formatter routing users through an interstitial "you are leaving the site" page** before external
links (external-link disclaimers — gov/institutional sites). Depends on core `link`. Version **1.1.x** (dev).
Core `^9||^10||^11`.

Content-display/formatter — the interstitial redirects to the link field's (editor-set) URL (treat as any
editor-supplied URL if link fields are less-trusted). No access role.
