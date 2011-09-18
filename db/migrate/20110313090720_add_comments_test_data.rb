# -*- coding: utf-8 -*-
class AddCommentsTestData < ActiveRecord::Migration
  def self.up
    Comment.create(
      :content => "我是注释我是注释我是注释我是注释我是注释我是注释我是注释我是注释我是注释我是注释我是注释我是注释我是注释我是注释",
      :gadget_id => 3,
      :author_id => 55
    )
  end

  def self.down
  end
end
