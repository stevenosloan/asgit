def eat_stdout!
  output = StringIO.open('','w+')
  $stdout = output
end