___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Array to string, sum or array",
  "categories": ["UTILITY"],
  "description": "Convert an array of objects (eg. ecommerce items) to a single string with all the chosen sub-parameters, a sum of the values of a sub-parameter, or a new array of the chosen sub-parameters.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "input",
    "displayName": "Input array",
    "simpleValueType": true,
    "alwaysInSummary": true,
    "notSetText": "This value must be set",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "parameter",
    "displayName": "Parameter to format",
    "simpleValueType": true,
    "alwaysInSummary": true,
    "notSetText": "This value must be set"
  },
  {
    "type": "RADIO",
    "name": "format",
    "displayName": "Format as...",
    "radioItems": [
      {
        "value": "string",
        "displayValue": "Text (string)"
      },
      {
        "value": "sum",
        "displayValue": "Sum"
      },
      {
        "value": "array",
        "displayValue": "List (array)"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "string"
  },
  {
    "type": "GROUP",
    "name": "formatOptions",
    "displayName": "Format options",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "TEXT",
        "name": "stringDelimiter",
        "displayName": "Text delimiter",
        "simpleValueType": true,
        "canBeEmptyString": true,
        "alwaysInSummary": true,
        "enablingConditions": [
          {
            "paramName": "format",
            "paramValue": "string",
            "type": "EQUALS"
          }
        ],
        "defaultValue": "|",
        "valueHint": "|",
        "help": "This will be put between each value on the resulting string."
      },
      {
        "type": "CHECKBOX",
        "name": "switchDecimalSymbol",
        "checkboxText": "Change decimal symbol from comma to dot",
        "simpleValueType": true,
        "alwaysInSummary": true,
        "defaultValue": false,
        "help": "In order for the sum to work, decimal separator on the numbers must be a dot. Check this box if you need this tag to convert the comma to dot before adding the numbers.",
        "enablingConditions": [
          {
            "paramName": "format",
            "paramValue": "sum",
            "type": "EQUALS"
          }
        ]
      }
    ],
    "enablingConditions": [
      {
        "paramName": "format",
        "paramValue": "string",
        "type": "EQUALS"
      },
      {
        "paramName": "format",
        "paramValue": "sum",
        "type": "EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const getType = require("getType");
const makeNumber = require("makeNumber");

if (getType(data.input) !== "array") {
  return undefined;
}

if (data.format === "string") {
  return data.input.map(item => item[data.parameter]).filter(item => item).join(data.stringDelimiter); 
}

if (data.format === "sum") {
  return data.input.reduce((current, next) => {
    let nextValue = next[data.parameter];
    const nextValueType = getType(nextValue);
    
    if (nextValueType !== "string" && nextValueType !== "number") {
      return current + 0;
    } else {
      if (nextValueType === "string") nextValue = nextValue.replace(",", "."); // we switch the decimal comma by a dot
      return current + makeNumber(nextValue);
    }
  }, 0); 
}

if (data.format === "array") {
  return data.input.map(item => item[data.parameter]).filter(item => item);
}

return undefined;


___TESTS___

scenarios: []


___NOTES___

v1.0


