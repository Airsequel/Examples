const path = require("path")

const port = 3333

module.exports = {
  mode: "development",
  entry: [
    `webpack-dev-server/client?http://localhost:${port}`,
    "webpack/hot/dev-server",
    "./src/main.jsx",
  ],
  output: {
    filename: "bundle.js",
    path: path.join(__dirname, "/public"),
  },
  devtool: "source-map",
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        loader: "babel-loader",
      },
    ],
  },
  optimization: {
    moduleIds: "named",
  },
}
