var webpack = require('webpack');

module.exports = {
  entry: "./index.coffee",
  output: {
      path: __dirname,
      filename: "bundle.js"
  },
  module: {
    loaders: [
      { test: /\.coffee$/, loader: "coffee" },
      { test: /\.css$/, loader: "style!css" },
      { test: /\.scss$/, loaders: [
          "style-loader",
          "css-loader",
          "autoprefixer-loader?browsers=last 2 version",
          "sass-loader?imagePath=./blocks"
        ]
      },
      { test: /\.(png|svg)$/, include: /card\/__suit/, loader: "url" }
    ]
  },
  plugins: [
    new webpack.ProvidePlugin({
      jQuery: "jquery",
      $: "jquery"
    })
  ]
}
