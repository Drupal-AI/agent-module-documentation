# schema_recipe — agent start

Submodule of **schema_metatag**. Adds **Schema.org/Recipe** structured data as Metatag *Tag*
plugins in the `schema_recipe` group. No config UI, API, drush, or permissions of its own — configure
its tags under the site's Metatag defaults/overrides (**Admin → Config → Search and metadata →
Metatag**); values are token-driven and rendered into the page's JSON-LD by `schema_metatag`.

- Tags: name, description, image, author, datePublished, keywords, recipeCategory, recipeCuisine, recipeIngredient, recipeInstructions, recipeYield, prepTime/cookTime/totalTime, nutrition, aggregateRating, review, @type, @id.
- Use for recipe content to qualify for recipe rich cards and carousels.
