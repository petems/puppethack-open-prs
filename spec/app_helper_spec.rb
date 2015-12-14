describe 'app_helper' do
  let(:octo_client_ready) {
    instance_double('Octokit::Client',
      issue_comments: [
        {
          html_url:'https://github.com/org/repo/pull/666#issuecomment-666666',
          id: 666666,
          user:{
            login:'user',
            id: 666667,
            type:'User'
          },
         body:':+1: '
        },
        {
          html_url:'https://github.com/org/repo/pull/666#issuecomment-666666',
          id: 666666,
          user:{
            login:'another_user',
            id: 666668,
            type:'User',
          },
          body:'lot of text and :shipit: :smiley:'
        }
      ],
      pull_comments: [
        {
          url:'https://api.github.com/repos/org/repo/pulls/comments/666666',
          id: 666666,
          diff_hunk:'<<code>>',
          position:1,
            user:{
            login:'user',
            id: 666666,
            type:'User'
          },
          body:'yay! comments!',
          html_url:'https://github.com/org/repo/pull/666#discussion_r666666',
          pull_request_url:'https://api.github.com/repos/org/repo/pulls/666',
        },
        {
          url:'https://api.github.com/repos/org/repo/pulls/comments/666666',
          id: 666667,
          diff_hunk:'<<code>>',
          position:1,
          user:{
            login: session[:user],
            id: session[:user_id],
            type:'User'
          },
          body:':grin:',
          html_url:'https://github.com/org/repo/pull/666#discussion_r666666',
          pull_request_url:'https://api.github.com/repos/org/repo/pulls/666',
        },
        {
          url:'https://api.github.com/repos/org/repo/pulls/comments/666666',
          id: 666668,
          diff_hunk:'<<code>>',
          position:1,
            user:{
            login:'and_another',
            id: 666668,
            type:'User'
          },
          body:'and more comments!',
          html_url:'https://github.com/org/repo/pull/666#discussion_r666666',
          pull_request_url:'https://api.github.com/repos/org/repo/pulls/666',
        }
      ]
    )
  }

  let(:octo_client_not_ready) {
    instance_double('Octokit::Client',
      issue_comments: [
        {
          html_url:'https://github.com/org/repo/pull/666#issuecomment-666666',
          id: 666666,
          user:{
            login:'user',
            id: 666667,
            type:'User'
          },
         body:"you can't merge it yet :sad:"
        },
        {
          html_url:'https://github.com/org/repo/pull/666#issuecomment-666666',
          id: 666666,
          user:{
            login:'another_user',
            id: 666668,
            type:'User',
          },
          body:'lot of text and :shipit: :smiley:'
        }
      ],
      pull_comments: [
        {
          url:'https://api.github.com/repos/org/repo/pulls/comments/666666',
          id: 666666,
          diff_hunk:'<<code>>',
          position:1,
            user:{
            login:'user',
            id: 666666,
            type:'User'
          },
          body:'yay! comments!',
          html_url:'https://github.com/org/repo/pull/666#discussion_r666666',
          pull_request_url:'https://api.github.com/repos/org/repo/pulls/666',
        },
        {
          url:'https://api.github.com/repos/org/repo/pulls/comments/666666',
          id: 666667,
          diff_hunk:'<<code>>',
          position:1,
          user:{
            login:'another_user',
            id: 666668,
            type:'User'
          },
          body:':grin:',
          html_url:'https://github.com/org/repo/pull/666#discussion_r666666',
          pull_request_url:'https://api.github.com/repos/org/repo/pulls/666',
        },
        {
          url:'https://api.github.com/repos/org/repo/pulls/comments/666666',
          id: 666668,
          diff_hunk:'<<code>>',
          position:1,
            user:{
            login:'and_another',
            id: 666669,
            type:'User'
          },
          body:'and more comments!',
          html_url:'https://github.com/org/repo/pull/666#discussion_r666666',
          pull_request_url:'https://api.github.com/repos/org/repo/pulls/666',
        }
      ]
    )
  }

  let(:session) {
    session = {
      user: "user",
      user_id: 666667
    }
  }

  it 'returns true if pull can be merged' do
    result = can_merge_it?(octo_client_ready.issue_comments('org/repo',666))

    expect(result).to be_truthy
  end

  it 'returns false if pull can not be merged' do
    result = can_merge_it?(octo_client_not_ready.issue_comments('org/repo',666))

    expect(result).to be_falsey
  end

  it "returns false if you didn't reviewed yet" do
    result = reviewed_it?(octo_client_not_ready.issue_comments('org/repo',666))

    expect(result).to be_falsey
  end

  it "returns true if you reviewed it" do
    result = reviewed_it?(octo_client_ready.issue_comments('org/repo',666))

    expect(result).to be_truthy
  end

  it "returns true if you commented it" do
    result = comments?(octo_client_ready.pull_comments('org/repo',666))

    expect(result).to be_truthy
  end

  it "returns false if you didn't commented it" do
    result = comments?(octo_client_not_ready.pull_comments('org/repo',666))

    expect(result).to be_falsey
  end


end
