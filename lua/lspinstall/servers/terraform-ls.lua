local config = require'lspconfig'.terraformls.document_config
require'lspconfig/configs'.terraformls = nil -- important, immediately unset the loaded config again
config.default_config.cmd[1] = "./terraform-ls"

return vim.tbl_extend('error', config, {
  install_script = [[
  os=$(uname -s | tr "[:upper:]" "[:lower:]")
  arch=$(uname -p)
  version=$(curl -s "https://api.github.com/repos/hashicorp/terraform-ls/releases/latest" | awk -F '"' '/tag_name/{print $4}' | tr -d 'v')

  case $os in
    linux)
      platform="linux"
    ;;
    darwin)
      platform="darwin"
      if test "$arch" -eq "i386"; then
        arch="amd64";
      fi
    ;;
  esac

  curl -L -o terraform-ls.zip "https://github.com/hashicorp/terraform-ls/releases/download/v${version}/terraform-ls_${version}_${platform}_${arch}.zip"
  unzip terraform-ls.zip
  chmod +x terraform-ls
  ]]
})
