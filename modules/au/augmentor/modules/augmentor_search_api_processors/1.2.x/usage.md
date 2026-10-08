Search API Augmentor Processors lets a configured Augmentor rewrite or enrich field values at index time, or transform the search keywords at query time, by plugging Augmentor into the Search API processing pipeline.

---

This submodule adds two Search API processors that run a chosen Augmentor over text as it flows through Search API. "Augmentor Preprocess Index" (`augmentor_preprocess_index`, class `AugmentorPreprocessIndex` extending `FieldsProcessorPluginBase`) runs during the index preprocess (and pre-index-save) stages: for each selected field value it executes the augmentor and replaces the value with the augmentor's response under a configured response key. "Augmentor Preprocess Query" (`augmentor_preprocess_query`, class `AugmentorPreprocessQuery`, a subclass of the index processor) runs during the query preprocess stage to transform the incoming search keywords the same way. Both are configured per Search API index with two settings: the augmentor to run and the response key to extract. The module requires `augmentor` and `search_api`; it adds no routes, permissions, or config schema of its own (configuration is stored in the Search API index config).

---

- Generate embeddings-friendly or normalised text for a field before it is indexed.
- Translate field values into a common language at index time so multilingual content is searchable together.
- Summarise long body text into a shorter indexed representation to improve relevance.
- Expand indexed content with AI-derived keywords/synonyms for better recall.
- Classify or tag documents during indexing and index the resulting label.
- Clean or strip boilerplate from field text as part of the indexing pipeline.
- Rewrite a user's raw search query into a normalised or expanded form before it hits the backend.
- Translate the search query into the language the index was built in (query preprocess).
- Apply spelling/intent correction to search keywords via an AI augmentor at query time.
- Enrich short queries with related terms to widen matches.
- Run any custom Augmentor provider (OpenAI, NLP Cloud, etc.) as a Search API processor without extra code.
- Select which fields the index processor applies to using Search API's standard FieldsProcessor field selection.
- Pick the response key (e.g. `default`) to extract from a multi-key augmentor response for indexing/query.
- Combine index-time and query-time augmentation on the same index for symmetric transformation.
- Add AI processing to an existing Search API index purely through configuration on the index's Processors tab.
