<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Context Inject (context_inject) — agent index

**Provides Context reactions to inject raw HTML/JS snippets and attach asset libraries to context-matched pages.**

- **Version:** 1.0.x (1.0.1)
- **Core:** ^10 || ^11 (PHP 8.1)
- **Depends:** context
- **Reactions:** `AttachSnippet` (id `context_inject_snippet` — renders `Markup::create($config['snippet'])` at page top/bottom) and `AttachLibrary` (attaches a named asset library).
- **No routes, no services, no own permissions.**

**Security:** `AttachSnippet::execute()` (`src/Plugin/ContextReaction/AttachSnippet.php:34`) outputs its stored snippet as unfiltered trusted markup, so a reaction can place arbitrary HTML/JavaScript on every matched page. This is by design (that is the module's purpose) and is gated by the Context module's "administer contexts" permission — an already site-scripting-level privilege; grant only to fully trusted roles. No anonymous surface, no TLS/credential handling.

See [configure/reactions.md](configure/reactions.md)