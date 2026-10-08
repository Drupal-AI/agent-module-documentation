<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Fusion adds a `fusion` Solr connector so a Search API Solr server points at Lucidworks Fusion instead of a plain Solr server, and it feeds Fusion's behavioural-ranking pipeline with request and click signals. It also wires Fusion's autocomplete query profiles, spellcheck suggestions and promoted landing pages into Drupal search and Views.

---

Fusion is Lucidworks' commercial platform built on Apache Solr: it speaks the Solr API but adds query profiles, machine-learned ranking and a signals pipeline. Search API Solr talks to Solr; this module supplies the connector that makes "the Solr server" a Fusion app instead, so an existing Search API index keeps working while gaining Fusion features. Most operations still use Fusion's Solr API (`/api/solr`); search and autocomplete queries are routed to a Fusion query profile (`/api/apps/<app>/query/<profile>`), and signals go to the Signals API (`/api/signals/<app>`). Two signal types are produced: a request signal (sent by a Search API processor after each search) and a click signal (a `ping` URL attached to each result link, fired by the browser when a user clicks, and handled by a permission-gated route). Both are only sent for users who hold the "send signals to any Fusion server" permission. On top of that, an autocomplete suggester reads a Fusion query profile, and two Views area handlers surface Fusion spellcheck ("Did you mean…") and promoted landing pages. It only makes sense on a site that actually runs Fusion; with plain Solr there is nothing to connect to.

---

- Point a Search API Solr server at Lucidworks Fusion instead of plain Solr.
- Add a "Fusion" Solr connector when creating a Solr backend server.
- Keep existing Search API indexes working on Fusion.
- Route search queries through a Fusion query profile.
- Configure the Fusion app name, host and port (default 8764).
- Reuse Solr basic-auth credentials for the Fusion connection.
- Send request signals to Fusion after each search.
- Attach click-signal ping URLs to search result links.
- Feed Fusion's machine-learned ranking from user behaviour.
- Gate signal sending behind a dedicated permission.
- Grant signal access deliberately, per role.
- Add Fusion autocomplete based on a query profile.
- Show "Did you mean…" spellcheck suggestions from Fusion.
- Display Fusion promoted landing pages in a Views area.
- Include active facet filters in the signals sent to Fusion.
- Correlate clicks to a query via the Fusion query id.
- Improve search relevance over time from real clicks.
- Restrict which roles generate Fusion signals.
- Enable click signals with a single connector checkbox.
- Set the connector programmatically via the server config entity.
- Override the Views item link to carry the click ping attribute.
- Integrate a commercial Fusion search deployment with Drupal.
- Support faceted search backed by Fusion.
- Record which result position a user clicked.
