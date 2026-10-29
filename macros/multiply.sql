
{% macro multiply(left_expression, right_expression) -%}
    ({{ left_expression }} * {{ right_expression }})
{%- endmacro %}
