Adds Schema.org/QAPage and FAQPage JSON-LD structured data via Metatag, marking up question-and-answer or FAQ pages for Q&A and FAQ rich results.

---

Schema.org QAPage is a Schema.org Metatag submodule that registers Metatag tag plugins for the `QAPage`/`FAQPage` type. When enabled it adds a `Schema.org QAPage` group to Metatag configuration whose values render into the page's JSON-LD. It is deliberately small: a `@type` tag (choose QAPage or FAQPage), an `@id`, and a `mainEntity` property that holds the nested Question/Answer (or FAQ item) structure. The `mainEntity` accepts serialized/token-driven arrays so a repeating field of questions and accepted answers maps into the required Question → acceptedAnswer shape. It is used on support forums, community Q&A threads, and FAQ landing pages to qualify them for FAQ/Q&A rich results in Google. Because it is token-driven it can map an entire FAQ paragraph or field collection into structured data with one configuration.

---

- Mark a community question thread as a `QAPage`.
- Mark a curated FAQ landing page as an `FAQPage`.
- Choose between QAPage and FAQPage via the `@type` tag.
- Provide the `mainEntity` holding the Question and its acceptedAnswer.
- Map a repeating "FAQ item" field into the mainEntity structure.
- Emit multiple question/answer pairs from a paragraph field.
- Set a stable `@id` for the Q&A entity.
- Qualify support pages for FAQ rich results.
- Qualify user-generated Q&A threads for Q&A rich results.
- Improve SERP real estate with expandable FAQ snippets.
- Drive answer text from body/field tokens.
- Standardize FAQ markup across all documentation nodes.
- Distinguish single-answer FAQ from community multi-answer Q&A.
- Reduce manual JSON-LD authoring for FAQ content.
- Keep FAQ structured data in sync with editable content fields.
- Support knowledge-base pages seeking rich result eligibility.
