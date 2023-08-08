function SetWorkingDir()
  vim.cmd('cd %:h') -- changes working directory to location of current file
  local ok, git_dir = pcall(vim.cmd, '!git rev-parse --show-toplevel') -- gets git root dir
  if ok then
    vim.cmd(string.format('cd %s', git_dir)) -- change working dir to git root dir
  end
end
