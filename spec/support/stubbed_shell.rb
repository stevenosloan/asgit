module StubbedShell
  def stub_shell command, options={}
    stdout = options.fetch(:stdout, '')
    stderr = options.fetch(:stderr, '')
    status = options.fetch(:status, true)

    expect( Asgit::Shell ).to receive(:run)
                          .with(command)
                          .and_return( HereOrThere::Response.new( stdout, stderr, status ) )
  end
end