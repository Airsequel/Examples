module.exports = {
  parser: "@babel/eslint-parser",
  extends: [
    "eslint-config-javascript",
  ],
  env: {
    browser: true,
    jest: true,
  },
  globals: {
    defs: false,
  },
}
