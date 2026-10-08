<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Copy to Clipboard adds a copy button to any HTML element carrying the class `cp-to-clip`, so a visitor can copy the element's text without selecting it by hand.

---

Selecting text accurately is one of the small persistent frustrations of the web, and it is worst for exactly the values people most need to copy: an API key that wraps across two lines, a long reference number, a shell command, an IBAN, a discount code, a support ticket identifier. This module solves it the pragmatic way — as a **marker class rather than a field type, formatter or template change**. `cp2clip_preprocess_page()` attaches a global library (a dependency-free `js/cp2clip.js` plus `css/cp2clip.css`) to **every page**; the script runs once as a plain IIFE, finds every element with class `cp-to-clip`, appends a small `<div class="copy_to_clipboard">` icon and wires a click handler onto the whole element. Clicking the text or the icon runs `navigator.clipboard.writeText(element.textContent.trim())`, flips the element to a `copied` state (green), and resets the others. An editor applies the class from a WYSIWYG by registering styles such as `p.cp-to-clip`, `span.cp-to-clip`, `div.cp-to-clip` on a text format's styles dropdown; there is **no configuration page, no permissions and no settings** — install and mark up. Version **1.0.1-rc2** on core `^10 || ^11`, package UI, not covered by the security advisory policy. Three practical caveats, all about the button rather than the copying. The copy control is a **plain `<div>`, not a `<button>`**: it is not keyboard-focusable and carries no ARIA, so keyboard and assistive-technology users cannot trigger it and get no announced confirmation — the only feedback is the visual colour flip and a `title` change. The behaviour is **not registered as a `Drupal.behaviors` callback**, so the IIFE runs a single time at load; elements injected later by AJAX or a modal get no button. And the **Clipboard API requires a secure context**, so copy silently fails (logging to the console) on a site served over plain HTTP.

---

- Add a copy button to a code snippet by wrapping it in `<pre class="cp-to-clip">`.
- Copy an API key without selecting it.
- Copy a reference number on mobile where manual selection is hard.
- Add copy to a discount or coupon code.
- Copy a shell/composer command from documentation.
- Copy an IBAN or account number from a payment page.
- Add copy to a support ticket id.
- Copy a tracking number from an order confirmation.
- Improve documentation-page usability with per-block copy.
- Copy a licence key from an account page.
- Add copy to a generated password or token.
- Copy a share URL from a panel.
- Reduce copy-paste errors on long strings.
- Copy a configuration or environment value shown on a status page.
- Add copy to an order reference on a receipt.
- Copy a formatted citation.
- Let editors enable copy from the WYSIWYG styles dropdown, no code change.
- Add copy to a wrapped, multi-line value that is awkward to select by hand.
- Provide a dependency-free alternative to clipboard.js-based modules.
- Mark up a DID / wallet address / hash for one-click copying.

