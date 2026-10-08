Adds Schema.org/Review JSON-LD structured data via Metatag, describing a review of an item (its rating, author, and body) for review rich results.

---

Schema.org Review is a Schema.org Metatag submodule that registers Metatag tag plugins for the `Review` type. Enabling it adds a `Schema.org Review` group to Metatag configuration where token-driven values render into the page's JSON-LD. It covers the properties Google needs for review snippets: `itemReviewed` (the thing being reviewed), `reviewRating` (with rating value and best/worst), `author`, `datePublished`, `name`, and `reviewBody`. The `@type` and `@id` tags allow specialization and cross-referencing so the Review can be nested inside a Product, Service, or Organization. Because values are token-driven, one configuration maps an entire "review" content type into structured data. It is used on critic/editorial review sites and on pages that publish first-party reviews of products, services, or media.

---

- Mark up an editorial review node as a `Review`.
- Identify the `itemReviewed` (product, service, movie, book, etc.).
- Provide a `reviewRating` with the rating value and scale.
- Set best/worst rating bounds for accurate star display.
- Attach the review `author` (as a Person or Organization).
- Record the review `name`/headline.
- Include the `reviewBody` text.
- Set `datePublished` for the review.
- Give the review a stable `@id` for reuse.
- Nest the Review inside a Product's markup.
- Nest the Review inside a Service or Organization.
- Qualify pages for review-snippet rich results.
- Show star ratings in search results.
- Standardize review markup across all review nodes via tokens.
- Map rating fields dynamically from content.
- Distinguish critic reviews from aggregate ratings.
- Publish first-party media/book/film reviews with structured data.
- Improve click-through with rating stars in the SERP.
