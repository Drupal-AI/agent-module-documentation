<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feed Tamper Read Time is a Tamper plugin for Feeds/Tamper import pipelines that turns an HTML value into an estimated reading time expressed in whole minutes.

---

Add the "Read Time Calculator" tamper to a field in a Feeds source (or any Tamper-driven pipeline) and it converts the incoming HTML into a minute count. The plugin loads the value into `DOMDocument`, removes `<script>` and `<style>` elements, collects the visible text nodes with `DOMXPath`, and normalises the whitespace. It then counts the words (`preg_split` on whitespace), divides by the configured Words Per Minute rate, rounds the result up with `ceil()`, and returns the number of minutes as a string.

Configuration is a single field: **Words Per Minute (WPM)**, a number input with a default of 200 and an allowed range of 50–1000 (step 10). At compute time the plugin also falls back to 200 if the effective WPM is less than 1. The plugin only reads the value to count words — nothing is rendered as markup and the output is a numeric string only — so it is a read-only transformation you can drop anywhere in a tamper chain to populate a "X min read" field from imported body content.

---

- Auto-calculate an "X min read" value during a Feeds import
- Derive reading time from an imported HTML body field
- Populate a read-time field from RSS, CSV, or XML source content
- Set a custom words-per-minute rate per import source
- Strip HTML down to plain text before counting words
- Exclude `<script>` and `<style>` content from the word count
- Round reading estimates up to whole minutes
- Use the sensible 200 WPM default without extra configuration
- Tune WPM between 50 and 1000 to match your audience's reading speed
- Add reading-time metadata to imported articles or blog posts
- Chain the tamper after other tampers in a Feeds pipeline
- Compute read time for migrated documentation pages
- Show estimated effort/length on imported long-form content
- Normalise reading estimates across multiple feeds with the same WPM
- Feed the resulting minute count into a numeric or text field
- Keep the read-time value in sync on every re-import
- Convert a scraped HTML article into a plain minute count
- Provide a lightweight alternative to client-side read-time widgets
- Populate a field editors can display as "5 min read"
- Reuse one WPM setting consistently across many source items
