<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search kint adds a search box to Kint's variable dumps, so finding one key in a Drupal render array stops meaning scrolling through several thousand collapsed nodes.

---

Devel's `kint()` is the standard way to inspect a variable in Drupal, and it works well until the variable is a render array or a loaded node — structures nested dozens of levels deep with hundreds of keys, where the thing you want is somewhere inside and Kint's collapsed tree gives no way to find it but expanding branches one at a time. This module adds the missing search: `search_kint.search.js` highlights matching keys and expands the tree to reveal them (with a match count), and `search_kint.trail.js` shows the path to a match — which is the genuinely useful half, since knowing a key exists matters less than knowing how to reach it in code. It depends on `devel ^5.1` and `kint-php/kint ^5.0 | ^6.0` and is otherwise four small files, with no routes, permissions or configuration. The release is 2.0.0-beta2 and the core requirement is `^10 || ^11`. As a Devel companion it is a development-only module: Devel itself should not be enabled in production, and this inherits that entirely.

---

- Search a large Kint dump for a key.
- Find a value inside a render array.
- See the path to a nested key.
- Debug a deeply nested entity structure.
- Avoid expanding a Kint tree by hand.
- Locate a field value in a loaded node.
- Find where a render array property is set.
- Speed up debugging of a complex variable.
- Trace a value's location for use in code.
- Inspect a Views result row.
- Search a configuration object dump.
- Find a token in a large array.
- Debug a theme preprocess variable.
- Locate a service's property.
- Reduce time spent in Kint output.
- Teach a developer to read render arrays.
- Find a deeply nested cache tag.
- Debug a form array.
