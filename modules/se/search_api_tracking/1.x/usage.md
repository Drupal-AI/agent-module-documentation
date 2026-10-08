<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Tracking records searches performed through Search API into the database, for analytics on what users search for.

---

What visitors search for is valuable — it reveals content gaps, popular topics, and failed searches that lead nowhere. Search API does the searching but does not, by itself, keep a record of the queries. Search API Tracking adds that: it logs searches run through Search API into the database, so you can report on search terms, frequency, and result counts.

The data-handling consideration is that **search queries can be personal or sensitive**. People search for health conditions, names, private topics; a stored log of queries — especially if tied to a user or session — is a record that carries privacy weight and, on a regulated site, obligations. So the log should have a retention policy, its access should be restricted to those who need the analytics, and consideration given to whether queries are stored against identifiable users.

For understanding and improving site search, it is directly useful. Treat the query log as data that may contain sensitive terms: restrict who can read it, set a retention limit, and exclude it from casual database sharing.

---

- Log searches from Search API.
- Analyze what users search for.
- Find content gaps from searches.
- See popular search terms.
- Track failed searches.
- Report on search frequency.
- Store queries in the database.
- Improve site search.
- Identify zero-result searches.
- Restrict who reads the query log.
- Set a retention policy for queries.
- Treat search terms as sensitive.
- Measure search usage.
- Find missing content.
- Track result counts.
- Understand search behavior.
- Exclude the log from casual sharing.
- Report on search trends.
- Guide content strategy.
- Audit search demand.