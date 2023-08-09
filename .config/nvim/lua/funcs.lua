function SetWorkingDir()
  vim.cmd('cd %:h') -- changes working directory to location of current file
  local git_dir = vim.fn.system("git rev-parse --show-toplevel")
  vim.cmd(string.format('cd %s', git_dir))
end

