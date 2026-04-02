class PagesController < ApplicationController
  def show
  @page = Page.where("LOWER(title) = ?", params[:title].downcase).first

  unless @page
    render plain: "Page not found", status: 404
  end
end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update(page_params)
      redirect_to page_path(@page.title), notice: "Page updated"
    else
      render :edit
    end
  end

  private

  def page_params
    params.require(:page).permit(:title, :content)
  end
end