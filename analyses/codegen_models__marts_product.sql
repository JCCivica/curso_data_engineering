{% set models_to_generate = codegen.get_models(directory='marts/product', prefix='datamart') %}
{{ codegen.generate_model_yaml(
    model_names = models_to_generate
) }}