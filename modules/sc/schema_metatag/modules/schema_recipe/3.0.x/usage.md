Adds Schema.org/Recipe JSON-LD structured data via Metatag, describing a recipe with ingredients, times, yield, nutrition, and ratings for recipe rich results.

---

Schema.org Recipe is a Schema.org Metatag submodule that registers Metatag tag plugins for the `Recipe` type. Enabling it adds a `Schema.org Recipe` group to Metatag configuration where each property is token-driven and rendered into the page's JSON-LD block. It covers the full set of properties Google uses for recipe rich results: `name`, `description`, `image`, `author`, `datePublished`, `keywords`, `recipeCategory`, `recipeCuisine`, `recipeIngredient`, `recipeInstructions`, `recipeYield`, `prepTime`, `cookTime`, `totalTime` (ISO‑8601 durations), `nutrition`, `aggregateRating`, and `review`. The `@type` and `@id` tags allow specialization and cross-referencing. Because values map from tokens, a single configuration covers every recipe node, mapping multi-value ingredient and instruction fields into the required arrays. It is the standard way to make food/recipe content eligible for recipe carousels and star-rating rich results.

---

- Mark up a recipe node as a `Recipe`.
- Set the recipe `name`, `description`, and `image`.
- Attach the `author` (as a Person) of the recipe.
- Record `datePublished` for the recipe.
- Map a multi-value ingredient field into `recipeIngredient`.
- Map ordered steps into `recipeInstructions`.
- Provide `prepTime`, `cookTime`, and `totalTime` as ISO‑8601 durations.
- State the `recipeYield` (servings/quantity).
- Categorize with `recipeCategory` (e.g. dessert) and `recipeCuisine` (e.g. Italian).
- Add `keywords` for the dish.
- Include `nutrition` information (calories, etc.).
- Add `aggregateRating` for star ratings in results.
- Include individual `review` markup.
- Qualify content for Google recipe rich cards and carousels.
- Standardize recipe markup across all food nodes via tokens.
- Surface cook time and ratings directly in search snippets.
- Feed voice assistants structured cooking steps.
- Keep structured data synced with editable recipe fields.
- Distinguish recipe variants with a stable `@id`.
- Improve discoverability of a recipe archive.
